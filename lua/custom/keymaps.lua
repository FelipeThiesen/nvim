-- =====================================================================
-- 1. EXECUÇÃO DE CÓDIGO COM FLAGS DE COMPILAÇÃO
-- =====================================================================
vim.api.nvim_create_user_command('RunCode', function()
  local filetype = vim.bo.filetype
  local filename = vim.fn.expand('%')
  local basename = vim.fn.expand('%:r')
  local cmd = ''

  if filetype == 'python' then
    cmd = 'python3 ' .. filename
  elseif filetype == 'c' then
    -- -Wall e -Wextra: Ativam os avisos essenciais e extras.
    -- -std=c17: Usa o padrão moderno e estável da linguagem C.
    cmd = 'gcc -Wall -Wextra -std=c17 ' .. filename .. ' -o ' .. basename .. ' && ./' .. basename
  elseif filetype == 'cpp' then
    -- -O2: Otimização de tempo de execução (crucial em maratonas).
    -- -std=c++20: Obrigatório para poder usar a biblioteca <format>.
    cmd = 'g++ -Wall -Wextra -O2 -std=c++20 ' .. filename .. ' -o ' .. basename .. ' && ./' .. basename
  else
    print('Linguagem não configurada.')
    return
  end

  vim.cmd('botright 15split | term ' .. cmd)
  vim.cmd('startinsert')
end, {})

vim.keymap.set('n', '<F5>', ':RunCode<CR>', { noremap = true, silent = true, desc = 'Executar Código' })


-- =====================================================================
-- 2. INJEÇÃO DE ESQUELETOS (BOILERPLATE)
-- =====================================================================

-- Atalho: <espaço> + e + c (ESkeleton C)
vim.keymap.set('n', '<leader>ec', function()
  local lines = {
    "#include <stdio.h>",
    "#include <stdlib.h>",
    "",
    "int main(void) {",
    "    ",
    "    return 0;",
    "}"
  }
  -- Insere as linhas no início do arquivo
  vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
  -- Move o cursor automaticamente para a linha 5, com a indentação correta
  vim.cmd("normal! 5G")
  vim.cmd("startinsert!")
end, { desc = "Inserir Esqueleto C" })

-- Atalho: <espaço> + e + p (ESkeleton C++)
vim.keymap.set('n', '<leader>ep', function()
  local lines = {
    "#include <iostream>",
    "using namespace std;",
    "",
    "int main() {",
    "    ios_base::sync_with_stdio(false);",
    "    cin.tie(NULL);",
    "",
    "",
    "    return 0;",
    "}"
  }
  vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
  vim.cmd("normal! 9G")
  vim.cmd("startinsert!")
end, { desc = "Inserir Esqueleto C++ (CP)" })
