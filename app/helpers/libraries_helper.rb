module LibrariesHelper
  def libraries_for_select
    Library.all.collect do
    |l|
      [l.name, l.id]
    end
  end
end
