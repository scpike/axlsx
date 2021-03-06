# encoding: UTF-8
module Axlsx
  # A graphic frame defines a container for a chart object
  # @note The recommended way to manage charts is Worksheet#add_chart
  # @see Worksheet#add_chart
  class GraphicFrame

    # A reference to the chart object associated with this frame
    # @return [Chart]
    attr_reader :chart

    # A anchor that holds this frame
    # @return [TwoCellAnchor]
    attr_reader :anchor

    # Creates a new GraphicFrame object
    # @param [TwoCellAnchor] anchor
    # @param [Class] chart_type
    def initialize(anchor, chart_type, options)
      DataTypeValidator.validate "Drawing.chart_type", Chart, chart_type
      @anchor = anchor
      @chart = chart_type.new(self, options)
    end

    # The relationship id for this graphic
    # @return [String]
    def rId
      "rId#{@anchor.index+1}"
    end

    # Serializes the object
    # @param [String] str
    # @return [String]
    def to_xml_string(str = '')
      str << '<xdr:graphicFrame>'
      str << '<xdr:nvGraphicFramePr>'
      str << '<xdr:cNvPr id="2" name="' << chart.title.text << '"/>'
      str << '<xdr:cNvGraphicFramePr/>'
      str << '</xdr:nvGraphicFramePr>'
      str << '<xdr:xfrm>'
      str << '<a:off x="0" y="0"/>'
      str << '<a:ext cx="0" cy="0"/>'
      str << '</xdr:xfrm>'
      str << '<a:graphic>'
      str << '<a:graphicData uri="' << XML_NS_C << '">'
      str << '<c:chart xmlns:c="' << XML_NS_C << '" xmlns:r="' << XML_NS_R << '" r:id="' << rId.to_s << '"/>'
      str << '</a:graphicData>'
      str << '</a:graphic>'
      str << '</xdr:graphicFrame>'
    end

  end
end
