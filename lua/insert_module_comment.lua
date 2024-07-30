return function()
  local current_line = vim.fn.line '.'
  local relative_filename = vim.fn.expand '%:.'

  -- Remove 'src/' or 'src\' prefix if present
  if relative_filename:find 'src/' == 1 or relative_filename:find 'src\\' == 1 then
    relative_filename = relative_filename:sub(5)
  end

  local top_length = 75
  local name = ' ' .. relative_filename .. ' '
  local tab = string.rep(' ', 4)

  local freespace = top_length - #name - 2
  local left = 0
  local right = 0

  if freespace > 0 then
    left = math.floor(freespace / 2)
    right = freespace - left
  end

  local top_of_comment = string.rep('=', left) .. ' ' .. name .. ' ' .. string.rep('=', right)

  vim.api.nvim_buf_set_lines(0, current_line, current_line, true, {
    '/*',
    tab .. top_of_comment,
    tab .. 'This is a module description, you can put whatever you want here...',
    tab .. string.rep('-', #top_of_comment),
    '*/',
  })
end
