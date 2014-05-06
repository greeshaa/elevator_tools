require 'test_helper'

class EquipmentLineItemsControllerTest < ActionController::TestCase
  setup do
    @equipment_line_item = equipment_line_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:equipment_line_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create equipment_line_item" do
    assert_difference('EquipmentLineItem.count') do
      post :create, equipment_line_item: { equipment_id: @equipment_line_item.equipment_id, equipment_move_buffer_id: @equipment_line_item.equipment_move_buffer_id }
    end

    assert_redirected_to equipment_line_item_path(assigns(:equipment_line_item))
  end

  test "should show equipment_line_item" do
    get :show, id: @equipment_line_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @equipment_line_item
    assert_response :success
  end

  test "should update equipment_line_item" do
    patch :update, id: @equipment_line_item, equipment_line_item: { equipment_id: @equipment_line_item.equipment_id, equipment_move_buffer_id: @equipment_line_item.equipment_move_buffer_id }
    assert_redirected_to equipment_line_item_path(assigns(:equipment_line_item))
  end

  test "should destroy equipment_line_item" do
    assert_difference('EquipmentLineItem.count', -1) do
      delete :destroy, id: @equipment_line_item
    end

    assert_redirected_to equipment_line_items_path
  end
end
