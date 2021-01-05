require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:location) { Location.new }

  context 'initial state' do
    subject {
      location
    }
    it "can get its initial attributes" do
      expect(subject.facing).to eq :north
      expect(subject.x).to eq 0
      expect(subject.y).to eq 0
      expect(subject.position).to eq [0,0]
    end
  end

  context 'changed state' do
    subject {
      location.facing = :south
      location.x = 1
      location.y = 2
      location
    }
    it "can set its attributes" do
      expect(subject.facing).to eq :south
      expect(subject.x).to eq 1
      expect(subject.y).to eq 2
      expect(subject.position).to eq [1,2]
    end
  end

  describe '#position=' do
    subject {
      location.position = [1,3]
      location
    }
    it 'updates x and y' do
      expect {
        subject
      }.to change { location.x }.from(0).to(1)
      .and change { location.y }.from(0).to(3)
    end
  end

  describe '#update' do
    subject {
      location.update(direction)
      location
    }

    context 'turns' do
      context 'from north' do
        before { location.facing = :north }

        context 'turning left' do
          let(:direction) { Turn.new(instruction: "left") }
          it 'turns left and faces the correct way' do
            expect(subject.facing).to eq :west
          end
        end

        context 'turning right' do
          let(:direction) { Turn.new(instruction: "right") }
          it 'faces the correct way' do
            expect(subject.facing).to eq :east
          end
        end
      end

      context 'from west' do
        before { location.facing = :west }

        context 'turning left' do
          let(:direction) { Turn.new(instruction: "left") }
          it 'faces the correct way' do
            expect(subject.facing).to eq :south
          end
        end

        context 'turning right' do
          let(:direction) { Turn.new(instruction: "right") }
          it 'faces the correct way' do
            expect(subject.facing).to eq :north
          end
        end
      end

      context 'from east' do
        before { location.facing = :east }

        context 'turning left' do
          let(:direction) { Turn.new(instruction: "left") }
          it 'faces the correct way' do
            expect(subject.facing).to eq :north
          end
        end

        context 'turning right' do
          let(:direction) { Turn.new(instruction: "right") }
          it 'faces the correct way' do
            expect(subject.facing).to eq :south
          end
        end
      end

      context 'from south' do
        before { location.facing = :south }

        context 'turning left' do
          let(:direction) { Turn.new(instruction: "left") }
          it 'faces the correct way' do
            expect(subject.facing).to eq :east
          end
        end

        context 'turning right' do
          let(:direction) { Turn.new(instruction: "right") }
          it 'faces the correct way' do
            expect(subject.facing).to eq :west
          end
        end
      end
    end

    context 'movement' do
      context 'facing north' do
        before {
          location.facing = :north
        }
        context 'from 0,0' do
          before {
            location.x = 0
            location.y = 0
          }
          context 'forward 1' do
            let(:direction) { Movement.new(direction: 'forward', distance: 1) }
            it 'moves position correctly' do
              expect(subject.position).to eq [0,1]
            end
          end

          context 'forward 2' do
            let(:direction) { Movement.new(direction: 'forward', distance: 2) }
            it 'moves position correctly' do
              expect(subject.position).to eq [0,2]
            end
          end
        end
        context 'from 1,2' do
          before {
            location.position = [1,2]
          }
          context 'forward 1' do
            let(:direction) { Movement.new(direction: 'forward', distance: 1) }
            it 'moves position correctly' do
              expect(subject.position).to eq [1,3]
            end
          end
        end
      end

      context 'facing east' do
        before {
          location.facing = :east
        }
        context 'from 0,1' do
          before {
            location.position = [0,1]
          }
          context 'forward 1' do
            let(:direction) { Movement.new(direction: 'forward', distance: 1) }
            it 'moves position correctly' do
              expect(subject.position).to eq [1,1]
            end
          end
        end
      end
    end
  end
end
