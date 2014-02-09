module ApplicationHelper
  def warrenty_link(asset, text)
    case asset.asset_type.name
    when 'Laptop'
      link_to text, "https://selfsolve.apple.com/wcResults.do?sn=#{asset.serial_number}&num=1234"
    else
      text
    end
  end
end