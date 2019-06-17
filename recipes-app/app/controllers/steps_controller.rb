class StepsController < ApplicationController
    
    skip_before_action :verify_authenticity_token  

    def edit
        @step = Step.find(params[:id])
    end

    def create
        # byebug
        Step.create(step_params)

    end

    def update
        # byebug
        Step.update(step_params)
    end

    def destroy
        
        @Step = Step.find(params[:id])
        @step.destroy
    
    end

    def step_params
        params.permit(
            :description        
        )

    end
end