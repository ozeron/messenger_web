class MassMailingsController < InheritedResources::Base

  private

    def mass_mailing_params
      params.require(:mass_mailing).permit(:title, :started, :finished)
    end
end

