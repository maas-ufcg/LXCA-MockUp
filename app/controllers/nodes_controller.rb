class NodesController < ApplicationController
  before_action :set_node, only: [:show, :edit, :update, :destroy]

  # GET /nodes
  # GET /nodes.json
  def index

    param = params[:status]
    if param.nil?
      @nodes = Node.all.to_a
    else
      @nodes = Node.all.to_a.select do |node|
        node.properties.to_hash.deep_symbolize_keys[:status][:message] == param
      end
    end
    render(json: @nodes.map do |node|
      setup_node_properties node
      node.properties
    end)
  end

  # GET /nodes/1
  # GET /nodes/1.json
#   def show
#     if @node.nil?
#       head :not_found
#     else
#       render json: @node.properties
#     end
# end


  # PATCH/PUT /nodes/1
  # PATCH/PUT /nodes/1.json
  # def update
  #   respond_to do |format|
  #     if @node.update(node_params)
  #       format.html { redirect_to @node, notice: 'Node was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @node }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @node.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_node
      @node = begin
          Node.find(params[:id])
        rescue Mongoid::Errors::DocumentNotFound => ex
        end
        setup_node_properties @node
    end

    def setup_node_properties(node)
      return if node.nil?
      excludeAttributes = split_to_sym params[:excludeAttributes]
      includeAttributes = split_to_sym params[:includeAttributes]



      unless includeAttributes.nil?
        excludeAttributes = NodesHelper::required_fields-includeAttributes
      end
      unless excludeAttributes.nil?
        excludeAttributes.each do |attribute|
          node.properties.delete(attribute)
        end
      end
    end

    def split_to_sym(string)
      string.split(",").map(&:to_sym) if string.is_a?(String)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def node_params
      params.require(:node).permit(:_id, :properties)
    end
end
