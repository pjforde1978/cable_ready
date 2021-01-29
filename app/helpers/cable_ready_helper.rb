# frozen_string_literal: true

module CableReadyHelper
  def stream_from(*keys)
    keys.select!(&:itself)
    identifier = keys.one? ? keys.pop : compound(keys)
    if identifier.class < ActiveRecord::Base
      return tag.div(data: {controller: "stream-from", stream_from_sgid_value: identifier.to_sgid(expires_in: nil).to_s})
    end
    tag.div(data: {controller: "stream-from", stream_from_identifier_value: identifier.to_s})
  end

  private

  def compound(keys)
    keys.map { |key|
      key.class < ActiveRecord::Base ? key.to_sgid(expires_in: nil).to_s : key.to_s
    }.join(":")
  end
end
