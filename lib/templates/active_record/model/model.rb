#encoding: utf-8
<% module_namespacing do -%>
class <%= class_name %> < <%= parent_class_name.classify %>

  # Constants
  # Put here constants for <%= class_name %>

  # Relations
<% attributes.select(&:reference?).each do |attribute| -%>
  belongs_to :<%= attribute.name %><%= ', polymorphic: true' if attribute.polymorphic? %>
<% end -%>
<% if attributes.any?(&:password_digest?) -%>
  has_secure_password
<% end -%>

  # Callbacks
  # Put here custom callback methods for <%= class_name %>

  # Validations
<% attributes.each do |attribute| -%>
  # validates :<%= attribute.name %>, <validations>
<% end -%>

  # Scopes (used for search form)
  # Put here custom queries for <%= class_name %>
  scope :by_name, ->(name) { where("name ILIKE ?", "%#{name}%") } # Scope for search

  # Instance methods

  # Override to_s method
  def to_s
    (defined? name)? name : ((defined? email)? email : id)  # editable
  end

end
<% end -%>
