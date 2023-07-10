module UserFlow
  class Update
    def initialize(params, current_user)
      @params = params
      @current_user = current_user
    end

    def call
      update_current_user!
    end

    private

    attr_reader :params, :current_user

    def update_current_user!
      current_user.update!(current_user_params)
    end

    def current_user_params
      params.permit(:name, :avatar, :email)
    end


  end
end
