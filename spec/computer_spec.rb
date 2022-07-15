require './lib/computer'

RSpec.describe Computer do

  it 'exists' do
    computer = Computer.new
    
    expect(computer).to be_instance_of(Computer)
  end

end