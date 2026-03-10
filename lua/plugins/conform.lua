return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "ConformInfo" },
    opts = {
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
    config = function(_, opts)
      -- auto-populate from mason
      local conform = require("conform")
      conform.setup(opts)

      local ok, registry = pcall(require, "mason-registry")
      if ok then
        registry.refresh(function()
          for _, pkg in ipairs(registry.get_installed_packages()) do
            local categories = pkg.spec.categories or {}
            for _, cat in ipairs(categories) do
              if cat == "Formatter" then
                local filetypes = pkg.spec.languages or {}
                for _, ft in ipairs(filetypes) do
                  ft = ft:lower()
                  local current = conform.formatters_by_ft[ft] or {}
                  if not vim.tbl_contains(current, pkg.name) then
                    table.insert(current, pkg.name)
                    conform.formatters_by_ft[ft] = current
                  end
                end
              end
            end
          end
        end)
      end
    end,
  },
}
