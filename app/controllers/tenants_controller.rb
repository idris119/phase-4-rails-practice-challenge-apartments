class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_response

    def index
        render json: Tenant.all, status: :ok
    end

    def show
        render json: Tenant.find(params[:id])
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def update
        tenant = Tenant.find(params[:id])
        tenant.update!(tenant_params)
    end

    def destroy
        tenant = tenant.find(params[:id])
        tenant.destroy
        head :no_content
    end

    private

    def record_not_found_response
        render json: {error: "Tenant not found"}, status: :not_found
    end

    def invalid_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}
    end

    def tenant_params
        params.permit(:name, :age)
    end
end
