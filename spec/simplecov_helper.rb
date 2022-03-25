require "simplecov"
require "simplecov_small_badge"

# Fix https://github.com/MarcGrimme/simplecov-small-badge/issues/15
SimpleCovSmallBadge::Formatter.class_eval do
  private

  def state(covered_percent)
    if SimpleCov.minimum_coverage[:line]&.positive?
      if covered_percent >= SimpleCov.minimum_coverage[:line]
        "good"
      else
        "bad"
      end
    else
      "unknown"
    end
  end
end

SimpleCov.start do
  # call SimpleCov::Formatter::BadgeFormatter after the normal HTMLFormatter
  SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCovSmallBadge::Formatter
  ])
end

# configure any options you want for SimpleCov::Formatter::BadgeFormatter
SimpleCovSmallBadge.configure do |config|
  # does not created rounded borders
  config.rounded_border = true
  # set the background for the title to darkgrey
  config.background = "#ffffcc"
end
