module ApplicationHelper
  def octicon(code, use_mega = false, extra_classes = nil)
    mega = use_mega ? "mega-" : ""
    content_tag :span, '', :class => "#{mega}octicon octicon-#{code.to_s.dasherize} #{extra_classes}"
  end

  def current_user
    true
  end
end
