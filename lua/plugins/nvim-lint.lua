return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {}

      -- auto-populate from mason
      local ok, registry = pcall(require, "mason-registry")
      if ok then
        registry.refresh(function()
          for _, pkg in ipairs(registry.get_installed_packages()) do
            local categories = pkg.spec.categories or {}
            for _, cat in ipairs(categories) do
              if cat == "Linter" then
                local filetypes = pkg.spec.languages or {}
                for _, ft in ipairs(filetypes) do
                  ft = ft:lower()
                  lint.linters_by_ft[ft] = lint.linters_by_ft[ft] or {}
                  if not vim.tbl_contains(lint.linters_by_ft[ft], pkg.name) then
                    table.insert(lint.linters_by_ft[ft], pkg.name)
                  end
                end
              end
            end
          end
        end)
      end

      local group = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = group,
        callback = function()
          lint.try_lint()
        end,
      })
      vim.api.nvim_create_user_command("LintInfo", function()
        local ft = vim.bo.filetype
        local linters = require("lint").linters_by_ft[ft] or {}
        if #linters == 0 then
          vim.notify("No linters configured for filetype: " .. ft, vim.log.levels.WARN)
        else
          vim.notify("Linters for " .. ft .. ": " .. table.concat(linters, ", "), vim.log.levels.INFO)
        end
      end, {})
    end,
  },
}
