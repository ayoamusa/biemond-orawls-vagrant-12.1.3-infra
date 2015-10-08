newproperty(:ensure) do
  include EasyType

  desc %q{ absent, present or updated.
    when present is specified, it will just check if the primary key record is available. If it is,
    nothing will be done. When you specify 'updated', puppet will ensure the data is as specfied 
    in the data property of the puppet definition.
  %}

  newvalue(:present) do
    if @resource.provider and @resource.provider.respond_to?(:create)
      @resource.provider.create
    else
      @resource.create
    end
    nil # return nil so the event is autogenerated
  end

  newvalue(:updated) do
    if @resource.provider and @resource.provider.respond_to?(:create)
      @resource.provider.create
    else
      @resource.create
    end
    nil # return nil so the event is autogenerated
  end


  newvalue(:absent) do
    if @resource.provider and @resource.provider.respond_to?(:destroy)
      @resource.provider.destroy
    else
      @resource.destroy
    end
    nil # return nil so the event is autogenerated
  end

  def insync?(is)
    if [:present, :updated].include?(should) && is == :present
      true
    else
      is == should
    end
  end


end