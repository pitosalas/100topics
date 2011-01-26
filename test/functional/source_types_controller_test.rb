require File.dirname(__FILE__) + '/../test_helper'
require 'source_types_controller'

# Re-raise errors caught by the controller.
class SourceTypesController; def rescue_action(e) raise e end; end

class SourceTypesControllerTest < Test::Unit::TestCase
  def setup
    @controller = SourceTypesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
