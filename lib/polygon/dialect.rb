module Polygon
  class Dialect < WLang::Html

    def tilde(buf, fn)
      text = evaluate(fn)
      buf << context.markdown(text)
    end

    tag '~', :tilde

    Tilt.prefer Tilt::WLangTemplate.with_options(:dialect => Dialect), 'wlang'
  end
end
