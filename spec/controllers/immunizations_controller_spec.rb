require File.dirname(__FILE__) + '/../spec_helper'

describe ImmunizationsController do
  fixtures :patient_data, :immunizations

  before do
    @user = stub(:user)
    controller.stub!(:current_user).and_return(@user)
    @patient_data = patient_data(:joe_smith)
  end

  it "should assign @immunization on get new" do
    get :new, :patient_datum_id => @patient_data.id.to_s
    assigns[:immunization].should be_new_record
  end

  it "should render edit template on get edit" do
    get :edit, :patient_datum_id => @patient_data.id.to_s, :id => @patient_data.immunizations.first.id.to_s
    response.should render_template('immunizations/edit')
  end

  it "should assign @immunization on get edit" do
    get :edit, :patient_datum_id => @patient_data.id.to_s, :id => @patient_data.immunizations.first.id.to_s
    assigns[:immunization].should == @patient_data.immunizations.first
  end

  it "should render create template on post create" do
    post :create, :patient_datum_id => @patient_data.id.to_s
    response.should render_template('immunizations/create')
  end

  it "should assign @immunization on post create" do
    post :create, :patient_datum_id => @patient_data.id.to_s
    assigns[:immunization].should_not be_new_record
  end

  it "should add an immunization on post create" do
    old_immunization_count = @patient_data.immunizations.count
    post :create, :patient_datum_id => @patient_data.id.to_s
    @patient_data.immunizations(true).count.should == old_immunization_count + 1
  end

  it "should render show partial on put update" do
    put :update, :patient_datum_id => @patient_data.id.to_s, :id => @patient_data.immunizations.first.id.to_s
    response.should render_template('immunizations/_show')
  end

  it "should update immunization on put update" do
    existing_immunization = @patient_data.immunizations.first
    put :update, :patient_datum_id => @patient_data.id.to_s, :id => existing_immunization.id.to_s,
      :immunization => { :lot_number_text => 'foobar' }
    existing_immunization.reload
    existing_immunization.lot_number_text.should == 'foobar'
  end

  it "should remove from @patient_data.immunizations on delete destroy" do
    existing_immunization = @patient_data.immunizations.first
    delete :destroy, :patient_datum_id => @patient_data.id.to_s, :id => existing_immunization.id.to_s
    @patient_data.immunizations(true).should_not include(existing_immunization)
  end

end

