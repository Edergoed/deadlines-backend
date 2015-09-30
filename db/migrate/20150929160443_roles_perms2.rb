class RolesPerms2 < ActiveRecord::Migration
  def change
  	create_table :roles_perms, id: false do |t|
      t.belongs_to :roles, index: true
      t.belongs_to :perms, index: true
    end
  end
end
