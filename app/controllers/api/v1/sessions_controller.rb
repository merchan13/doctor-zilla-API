module Api::V1
  class SessionsController < ApiController
    skip_before_action :require_login!, only: [:create]

    # POST /sign-in
    def create
      resource = User.find_for_database_authentication(:email => params[:user_login][:email])
      return invalid_login_attempt unless resource

      if resource.valid_password?(params[:user_login][:password])
        if resource.role == 'Doctor'
          auth_token = resource.generate_auth_token
          render json:
          {
            auth_token: auth_token,
            user_id: resource.id
          }
        else
          invalid_role
        end
      else
        invalid_login_attempt
      end

    end

    # DELETE /sign-out
    def destroy
      resource = current_user
      resource.invalidate_auth_token
      head :ok
    end

    private
      def invalid_login_attempt
        render json:
        {
          errors: "La contraseña o correo que introdujo son inválidos"
        }, status: 401
      end

      def invalid_role
        render json:
        {
          errors: "Sólo Doctores tienen acceso a la aplicación"
        }, status: 401
      end

  end
end
