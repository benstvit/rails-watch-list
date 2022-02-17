class RemoveColumnFromBookmarks < ActiveRecord::Migration[6.1]
  def change
    remove_reference :bookmarks, :movies, uniqueness: true
  end
end
