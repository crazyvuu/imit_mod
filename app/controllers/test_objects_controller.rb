class TestObjectsController < ApplicationController
  before_action :set_test_object, only: [:get_test_object, :update_test_object, :destroy_test_object]

  # GET /test_objects
  def get_test_objects
    @test_objects = TestObject.all
    return render json: {error: {code: 5, desc: 'Объект удален или не существует'}}, status: 404 if (@test_objects.blank?)
    return render json: {test_objects: @test_objects.as_json}, status: 200
  end

  # GET /test_objects/:toid
  def get_test_object
    return render json: {test_object: @test_object.as_json}, status: 200
  end

  # POST /test_objects
  def create_test_object
    @test_object = TestObject.create(test_object_params)
    return render json: {result: @test_object.as_json}, status: 200
  end

  # PATCH /test_objects/:toid
  def update_test_object
    return render json: {parameters: test_object_params}
    @test_object.update(test_object_params)
    return render json: '', status: 200
  end

  # DELETE /test_objects/:toid
  def destroy_test_object
    @test_object.destroy
    return render json: '', status: 200
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_test_object
    @test_object = TestObject.find_by(id: params[:toid])
    return render json: {error: {code: 5, desc: 'Объект удален или не существует'}}, status: 404 unless (@test_object)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def test_object_params
    params.require(:user_id)
    test_object_params = params.permit(:id, :user_id, :ts, :is_deleted, :title)
    test_object_params
  end
end
