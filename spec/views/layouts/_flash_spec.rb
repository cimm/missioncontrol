require "spec_helper"

describe "layouts/_flash" do
  it "shows the flash messages" do
    flash[:notice] = "Flash successfull"
    render
    rendered.should have_content("Flash successfull")
  end
end
