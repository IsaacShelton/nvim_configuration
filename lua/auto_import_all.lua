--[[
    ========================  lua/auto_import_all.lua  ========================
    Very helpful function for automatically importing all missing symbols.
    ---------------------------------------------------------------------------
]]

local function apply_code_action(action)
  if action.edit then
    vim.lsp.util.apply_workspace_edit(action.edit, 'utf-8')
  end
end

local function resolve_and_apply_code_action(action)
  local client = vim.lsp.get_client_by_id(1)
  if client and client.supports_method 'codeAction/resolve' then
    client.request('codeAction/resolve', action, function(err, resolved_action)
      if err then
        vim.notify('Error resolving code action: ' .. err.message, vim.log.levels.ERROR)
        return
      end
      apply_code_action(resolved_action or action)
    end)
  else
    apply_code_action(action)
  end
end

local solve_next
local get_code_actions
local restart_solve_diagnostics

solve_next = function(mode, diagnostics)
  if #diagnostics > 0 then
    local diag = table.remove(diagnostics, 1)

    if diag.severity == vim.diagnostic.severity.ERROR then
      get_code_actions(mode, diag, diagnostics)
    else
      solve_next(mode, diagnostics)
    end
  else
    vim.cmd 'write'
    if mode.retry > 0 then
      vim.wait(350)
      mode.retry = mode.retry - 1
      restart_solve_diagnostics(mode)
    end
  end
end

get_code_actions = function(mode, diag, diagnostics)
  local params = vim.lsp.util.make_range_params()
  params.context = { diagnostics = {} }
  params.range = {
    start = { line = diag.lnum, character = diag.col },
    ['end'] = { line = diag.end_lnum or diag.lnum, character = diag.end_col or diag.col + 1 },
  }

  vim.lsp.buf_request(diag.bufnr, 'textDocument/codeAction', params, function(err, actions, ctx)
    if err then
      vim.notify('LSP Error: ' .. err.message, vim.log.levels.ERROR)
      return
    end

    local fav_action = nil

    -- Find fav action
    if actions and not vim.tbl_isempty(actions) then
      local num_imports = 0
      for _, action in ipairs(actions) do
        if action.title:match '^Import ' then
          if fav_action == nil then
            fav_action = action
          end
          num_imports = num_imports + 1
        end
      end

      if mode.strict and num_imports ~= 1 then
        fav_action = nil
      end
    end

    -- Apply fav action
    if fav_action ~= nil then
      resolve_and_apply_code_action(fav_action)
      vim.wait(50)
      restart_solve_diagnostics(mode)
    else
      solve_next(mode, diagnostics)
    end
  end)
end

restart_solve_diagnostics = function(mode)
  local bufnr = vim.api.nvim_get_current_buf()
  local diagnostics = vim.diagnostic.get(bufnr)
  solve_next(mode, diagnostics)
end

return function(strictness)
  restart_solve_diagnostics { strict = strictness == 'strict', retry = 3 }
end
