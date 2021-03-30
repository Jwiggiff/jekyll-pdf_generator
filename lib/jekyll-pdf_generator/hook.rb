require 'puppeteer'

module Jekyll
  class PDF < Jekyll::StaticFile
    def initialize(site, base, dir, name)
      super
    end

    def write(dest)
      super
      trigger_hooks(:post_write)
    end

    def trigger_hooks(hook_name, *args)
      Jekyll::Hooks.trigger :pdfs, hook_name, self, *args
    end
  end
end

Jekyll::Hooks.register :pages, :post_render do |page|
  if page.data["pdf"] == true
    path = File.expand_path __dir__

    Puppeteer.launch() do |browser|
      browser_page = browser.pages.first || browser.new_page
      browser_page.set_content(page.output, wait_until: "networkidle0")
      browser_page.pdf(
          path: "#{path}/generated_files/#{page.basename}.pdf",
          format: "letter",
          margin: { top: "1cm", left: "1cm", right: "1cm", bottom: "1cm" },
        )
    end

    page.site.static_files << Jekyll::PDF.new(page.site, "#{path}/generated_files/", page.dir, "#{page.basename}.pdf")
    page.site.pages.delete(page)
  end
end

Jekyll::Hooks.register :pdfs, :post_write do |pdf|
  File.delete(__dir__+"/generated_files/#{pdf.name}") if File.exist?(__dir__+"/generated_files/#{pdf.name}")
end