require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
  let(:valid_attributes) do
    {
      name: 'Juanito',
      document: '1122111',
      email: 'juanito@email.com',
      reservation_date: "2019-11-12",
      movie_id: movie.id
    }
  end

  let(:movie) do
    Movie.create(name: 'Legally Blond', description: 'Chiguagua', url_image: 'https://image.com/image.jpg', begin_date: '2019-11-10', end_date: '2019-12-20')
  end

  describe "GET #index" do
    it "returns a success response" do
      reservation = Reservation.create! valid_attributes
      reservation2 = Reservation.create! valid_attributes

      get :index
      expect(response).to be_successful
      expect(json_response.count).to eq(2)
    end
  end

  describe "POST #create" do
    let(:invalid_attributes) do
      {
        another_param: 'invalid'
      }
    end

    context "with valid params" do
      it "creates a new Reservation" do
        expect {
          post :create, params: {reservation: valid_attributes}
        }.to change(Reservation, :count).by(1)
      end

      it "renders a JSON response with the new reservation" do

        post :create, params: {reservation: valid_attributes}
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new reservation" do

        post :create, params: {reservation: invalid_attributes}
        expect(response).to have_http_status(400)
      end
    end

    context "When reservation count is greater than 10" do
      it "renders a JSON response with errors for the new reservation" do

        10.times do
          Reservation.create!(name: 'Juan', movie_id: movie.id, email: "juanito@email.co", document: "232323", reservation_date: "2019-11-12")
        end
        Reservation.create!(name: 'Juan', movie_id: movie.id, email: "juanito@email.co", document: "232323", reservation_date: "2019-11-13")

        post :create, params: {reservation: valid_attributes}
        expect(response).to have_http_status(400)
      end
    end
  end

end
