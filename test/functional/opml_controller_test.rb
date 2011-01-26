require File.dirname(__FILE__) + '/../test_helper'
require 'opml_controller'

# Re-raise errors caught by the controller.
class OpmlController; def rescue_action(e) raise e end; end

class OpmlControllerTest < Test::Unit::TestCase
  def setup
    @controller = OpmlController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
