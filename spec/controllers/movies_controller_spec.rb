require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  describe "POST /movies" do
    let(:params) do
      {
        movie: {
          name: 'Maleficent: Mistress of Evil',
          description: "Maleficent travels to a grand old castle to celebrate young Aurora's upcoming wedding to Prince Phillip.",
          url_image: 'https://tumbrl.com/Maleficent',
          begin_date: '2019-10-10',
          end_date: '2019-11-10'
        }
      }
    end

    context "The params are valid" do

      it "Should create a new movie" do
        post :create, params: params

        expect(response.status).to eq(201)

        expect(Movie.count).to eq(1)

        movie = Movie.last
        expect(json_response["id"]).to eq(movie.id)

        expect(movie.name).to eq(params[:movie][:name])
        expect(movie.description).to eq(params[:movie][:description])
        expect(movie.url_image).to eq(params[:movie][:url_image])
        expect(movie.begin_date).to eq(DateTime.new(2019,10,10))
        expect(movie.end_date).to eq(DateTime.new(2019,11,10))
      end
    end

    context "The params are not valid" do
      it "Should create a new movie" do
        post :create, params: {movie: {not_valid: "argument"}}

        expect(response).not_to be_ok
        expect(response.status).to eq(400)

        expect(Movie.count).to eq(0)
        expect(json_response).to eq(
          "errors" => {
            "name"=>["can't be blank"],
            "description"=>["can't be blank"],
            "url_image"=>["can't be blank"],
            "begin_date"=>["can't be blank"],
            "end_date"=>["can't be blank"],
          }
        )
      end
    end

    context "The params are missing" do
      it "Should create a new movie" do
        post :create, params: {}

        expect(response).not_to be_ok
        expect(response.status).to eq(400)

        expect(Movie.count).to eq(0)
        expect(json_response).to eq(
          "error" => "param is missing or the value is empty: movie"
        )
      end
    end
  end

  describe "GET/movies" do
    context "No show_day provided" do
      it "should return 400" do
        get :index

        expect(response.status).to eq(400)
      end
    end

    context "show_day provided" do

      let!(:movie_1) do
        Movie.create(name: 'Maleficent', description: 'Cool movie', url_image: 'https://image.com/image.jpg', begin_date: '2019-10-10', end_date: '2019-10-20')
      end
      let!(:movie_2) do
        Movie.create(name: 'Legally Blond', description: 'Chiguagua', url_image: 'https://image.com/image.jpg', begin_date: '2019-11-10', end_date: '2019-12-20')
      end

      let!(:movie_3) do
        Movie.create(name: 'Locos Adams', description: 'Locos Admas what a Family', url_image: 'https://image.com/image.jpg', begin_date: '2019-11-10', end_date: '2019-12-20')
      end

      context "There are movies for the day provided" do
        it "should return 200 with an array of movies" do
          get :index, params: {show_day: '2019-11-15'}

          expect(response).to be_ok
          expect(json_response.count).to eq(2)
          expect(json_response).to match_array([
            a_hash_including(
              "id"=>movie_2.id,
              "name"=>movie_2.name,
              "description"=>"Chiguagua",
              "url_image"=>"https://image.com/image.jpg"
            ),
            a_hash_including(
              "id"=>movie_3.id,
              "name"=>movie_3.name,
              "description"=>"Locos Admas what a Family",
              "url_image"=>"https://image.com/image.jpg"
            )
          ])
        end
      end

      context "There are no movies for the day provided" do
        it "should return 200 with an array of movies" do
          get :index, params: {show_day: '2020-02-03'}

          expect(response).to be_ok
          expect(json_response.count).to eq(0)
        end
      end
    end
  end
end
