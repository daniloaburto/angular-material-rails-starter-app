<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]
  before_action :authorize_<%= plural_table_name %>, only: [:new, :create, :index]

  # GET <%= route_url %>
  def index
    @page = params[:page]

    <%= plural_table_name %>_filtered = params[:q].present? ? <%= class_name %>.by_name(params[:q]) : <%= orm_class.all(class_name) %>

    @<%= plural_table_name %> = <%= plural_table_name %>_filtered.paginate page: params[:page], per_page: 10

    # Display the data collected according to a format
    respond_to do |format|
      format.html
      format.json
      #format.csv { send_data @<%= plural_table_name %>.to_csv }
    end
  end

  # GET <%= route_url %>/1
  def show
  end

  # GET <%= route_url %>/new
  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
  end

  # GET <%= route_url %>/1/edit
  def edit
  end

  # POST <%= route_url %>
  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>

    if @<%= orm_instance.save %>
      redirect_to @<%= singular_table_name %>
    else
      render :new
    end
  end

  # PATCH/PUT <%= route_url %>/1
  def update
    if @<%= orm_instance.update("#{singular_table_name}_params") %>
      redirect_to @<%= singular_table_name %>
    else
      render :edit
    end
  end

  # DELETE <%= route_url %>/1
  def destroy
    if @<%= orm_instance.destroy %>
      redirect_to <%= index_helper %>_url
    else
      render :index
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_<%= singular_table_name %>
      @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
      authorize @<%= singular_table_name %>
    end

    # Authorization for class.
    def authorize_<%= plural_table_name %>
      authorize <%= class_name %>
    end

    # Only allow a trusted parameter "white list" through.
    def <%= "#{singular_table_name}_params" %>
      <%- if attributes_names.empty? -%>
      params[<%= ":#{singular_table_name}" %>]
      <%- else -%>
      params.require(<%= ":#{singular_table_name}" %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
      <%- end -%>
    end
end
<% end -%>
