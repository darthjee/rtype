class Engine::Battle::Group
  class DamageDistribuitor
    attr_accessor :members, :damage, :quantity
    delegate :sze, to: :members

    def initialize(members, damage)
      @members = members.to_a
      @damage = damage
      @quantity = members.sum(:quantity)
    end

    def apply
      distribute
      self.damage -= damages.values.sum
      distribute_randomly
      apply_damages
    end

    private

    def apply_damages
      damages.each do |squadron, damage|
        squadron.update(damage: squadron.damage + damage)
      end
    end

    def damages
      @damages ||= {}
    end

    def distribute
      members.each do |member|
        dam = damage * member.quantity / quantity
        damages[member] = dam
      end
    end

    def distribute_randomly
      while damage > 0 && members.present? do
        squadron = members.random!
        dam = (damage * squadron.quantity * 1.0 / quantity).ceil
        damages[squadron] += dam
        self.damage -= dam
      end
    end
  end
end
