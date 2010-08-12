module CarbonCalculatedApi
  class AnswerApp < API::App
        
    error 500 do
      {:errors => {:base => request.env['sinatra.error'].message}}.to_json
    end

    get "/computations/:computation_id/answer.json" do |computation_id|
      if params[:amount_of_material]
        File.read(File.join(File.dirname(__FILE__), "..", "responses", "answer_for_material.json"))
      else
         File.read(File.join(File.dirname(__FILE__), "..", "responses", "answer_errors.json"))
      end
    end
    
    get "/calculators/:calculator_id/answer.json" do |calculator_id|
      if params[:amount_of_material]
        File.read(File.join(File.dirname(__FILE__), "..", "responses", "answer_for_material.json"))
      else
         File.read(File.join(File.dirname(__FILE__), "..", "responses", "answer_errors.json"))
      end
    end

  end
end
