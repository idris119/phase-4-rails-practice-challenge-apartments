class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_response

    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    end

    private

    def record_not_found_response
        render json: {error: "Lease not found"}, status: :not_found
    end

    def invalid_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}
    end

    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end
end
