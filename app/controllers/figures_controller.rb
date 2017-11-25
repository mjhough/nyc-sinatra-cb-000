class FiguresController < ApplicationController

    get "/figures/new" do 
        @landmarks = Landmark.all
        @titles = Title.all
        erb :"figures/new"
    end

    post "/figures" do
        figure = Figure.create(params[:figure])
        
        if !params[:landmark][:name].empty?
            landmark = Landmark.create(params[:landmark])
            figure.landmarks << landmark
        end
        if !params[:title][:name].empty?
            title = Title.create(params[:title])
            figure.titles << title
        end
        redirect "/figures"
    end

    get "/figures" do
        @figures = Figure.all
        erb :"figures/index"
    end

    get "/figures/:id" do
        @figure = Figure.find(params[:id])
        erb :"figures/show"
    end

    get "/figures/:id/edit" do
        @figure = Figure.find(params[:id])
        @titles = Title.all
        @landmarks = Landmark.all
        erb :"figures/edit"
    end

    patch "/figures/:id" do
        figure = Figure.find(params[:id])
        figure.update(params[:figure])
        
        if !params[:landmark][:name].empty?
            landmark = Landmark.create(params[:landmark])
            figure.landmarks << landmark
        end

        if !params[:title][:name].empty?
            title = Title.create(params[:title])
            figure.titles << title
        end
        redirect "/figures/#{figure.id}"
    end
end