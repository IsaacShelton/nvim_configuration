local function starts_upper_case(str)
  if #str == 0 then
    return false
  end

  local first_char = string.sub(str, 1, 1)
  return first_char == string.upper(first_char)
end

local function to_title_case(str)
  return str:gsub('%f[%a]%a*', function(word)
    return word:sub(1, 1):upper() .. word:sub(2):lower()
  end)
end

local function smart_sub(line, from, to)
  local modified = false
  local new_line = ''
  local haystack = line:lower()
  local needle = from:lower()
  local last_i = 0

  while true do
    local start_i, end_i = string.find(haystack, needle, last_i, true)

    if not start_i or not end_i then
      break
    end

    new_line = new_line .. line:sub(last_i, start_i - 1)

    local found = line:sub(start_i, end_i)
    if starts_upper_case(found) then
      new_line = new_line .. to_title_case(to)
    else
      new_line = new_line .. to
    end

    last_i = end_i + 1
    modified = true
  end

  if last_i ~= 0 then
    new_line = new_line .. line:sub(last_i)
  end

  if not modified then
    return nil
  end

  return new_line
end

vim.api.nvim_create_user_command('S', function(opts)
  local from = opts.fargs[1]
  local to = opts.fargs[2]

  if from == nil or to == nil then
    vim.api.nvim_err_writeln 'Not enough arguments'
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)

  local lineNumber = opts.line1
  for _, line in ipairs(lines) do
    local modified_line = smart_sub(line, from, to)

    if modified_line ~= nil then
      vim.api.nvim_buf_set_lines(0, lineNumber - 1, lineNumber, false, { modified_line })
    end
    lineNumber = lineNumber + 1
  end
end, { nargs = '+', range = '%', desc = 'Case-Sensitive Word Substitution' })
