class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  private
  def set_locale
    locale = parse_language
    if !locale || (locale && !I18n.load_path.include?("#{Rails.root}/config/locales/#{locale}.yml"))
      locale = I18n.default_locale
    end
    session[:locale] = locale
    I18n.locale = locale
  end
  def parse_language
    return params[:locale].downcase.gsub('_', '-') if params[:locale].present?
    return session[:locale] if session[:locale]
    lang = env["HTTP_ACCEPT_LANGUAGE"] || ""
    begin
      lang.to_s.gsub(/\s+/, '').split(',').map do |language|
        locale, quality = language.split(';q=')
        raise ArgumentError, 'Not correctly formatted' unless locale =~ /^[a-z\-0-9]+|\*$/i
        next if locale == '*' # Ignore wildcards
        locale.downcase!
        l.gsub!('_', '-')
        quality = quality ? quality.to_f : 1.0
        [locale, quality]
      end.sort do |(_, left), (_, right)|
        right <=> left
      end.map(&:first).compact
    rescue ArgumentError # Just rescue anything if the browser messed up badly.
      []
    end.first
  end
end
