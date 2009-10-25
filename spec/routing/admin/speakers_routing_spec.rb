require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::SpeakersController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "admin_speakers", :action => "index").should == "/admin_speakers"
    end

    it "maps #new" do
      route_for(:controller => "admin_speakers", :action => "new").should == "/admin_speakers/new"
    end

    it "maps #show" do
      route_for(:controller => "admin_speakers", :action => "show", :id => "1").should == "/admin_speakers/1"
    end

    it "maps #edit" do
      route_for(:controller => "admin_speakers", :action => "edit", :id => "1").should == "/admin_speakers/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "admin_speakers", :action => "create").should == {:path => "/admin_speakers", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "admin_speakers", :action => "update", :id => "1").should == {:path =>"/admin_speakers/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "admin_speakers", :action => "destroy", :id => "1").should == {:path =>"/admin_speakers/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/admin_speakers").should == {:controller => "admin_speakers", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/admin_speakers/new").should == {:controller => "admin_speakers", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/admin_speakers").should == {:controller => "admin_speakers", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/admin_speakers/1").should == {:controller => "admin_speakers", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/admin_speakers/1/edit").should == {:controller => "admin_speakers", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/admin_speakers/1").should == {:controller => "admin_speakers", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/admin_speakers/1").should == {:controller => "admin_speakers", :action => "destroy", :id => "1"}
    end
  end
end
