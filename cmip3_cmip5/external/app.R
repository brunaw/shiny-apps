# Source reactive expressions and other code
source("external/reactives.R",local=T) # source reactive expressions
#source("external/reactives_leaflet.R",local=T) # source reactive expressions for leaflet
source("external/io_sidebar.R",local=T) # source input/output objects associated with sidebar
source("external/io_mainPanel.R",local=T) # source input/output objects associated with mainPanel

tsPlot <- source("external/plot_ts.R",local=T)$value
scatterPlot <- source("external/plot_scatter.R",local=T)$value
varPlot <- source("external/plot_variability.R",local=T)$value
heatPlot <- source("external/plot_heatmap.R",local=T)$value
spatialPlot <- source("external/plot_spatial.R",local=T)$value

# Specific plot function setup
doPlot_ts <- function(...){
	if(permitPlot() & !is.null(input$group)){
		if(!(input$group!="None" & !length(input$colorpalettes_ts))){
			tsPlot(d=dat(), x=input$xtime, y=aggStatsID(), y.name=input$aggStats, Log=input$log_ts, d.grp=datCollapseGroups(), d.pool=datCollapsePooled(), grp=input$group, n.grp=n.groups(), ingroup.subjects=subjectChoices(),
				panels=facet.panels(), facet.by=input$facet, vert.facet=input$vert.facet,
				fontsize=input$plotFontSize, colpal=input$colorpalettes_ts,
				linePlot=input$linePlot, barPlot=input$barPlot, pts.alpha=input$alpha1, bartype=input$bartype, bardirection=input$bardirection,
				show.points=input$ts_showpts, show.lines=input$ts_showlines, show.overlay=input$ts_showCRU, overlay=CRU(), jit=input$ts_jitterXY,
				plot.title=plot_ts_title(), plot.subtitle=plot_ts_subtitle(), show.panel.text=input$ts_showPanelText, show.title=input$ts_showTitle, lgd.pos=input$legendPos1,
				units=currentUnits(), yrange=input$yrange, clbootbar=input$clbootbar, clbootsmooth=input$clbootsmooth,
				pooled.var=pooled.var(), plot.theme.dark=input$ts_plotThemeDark, logo.mat=logo.mat, ...)
		} else NULL
	} else NULL
}

doPlot_scatter <- function(...){
	if(permitPlot() & !is.null(input$group2)){
		if(!(input$group2!="None" & !length(input$colorpalettes_sc))){
			scatterPlot(d=dat2(), x=input$vars, y=input$vars2, x.name=input$aggStats, y.name=input$aggStats2, Logx=input$log_sc_x, Logy=input$log_sc_y, flip.axes=sc_flip_xy(), grp=input$group2, n.grp=n.groups2(),
				panels=facet.panels2(), facet.by=input$facet2, vert.facet=input$vert.facet2,
				fontsize=input$plotFontSize2, colpal=input$colorpalettes_sc,
				show.points=input$sc_showpts, contourlines=input$sc_showlines, hexbin=input$hexbin, pts.alpha=input$alpha2, show.overlay=input$sc_showCRU, overlay=CRU2(), jit=input$sc_jitterXY,
				plot.title=plot_sp_title(), plot.subtitle=plot_sp_subtitle(), show.panel.text=input$sc_showPanelText, show.title=input$sc_showTitle,
				lgd.pos=input$legendPos2, units=currentUnits(),	pooled.var=pooled.var2(), plot.theme.dark=input$sc_plotThemeDark, logo.mat=logo.mat, ...)
		} else NULL
	} else NULL
}

doPlot_heatmap <- function(...){
	if(permitPlot() & !is.null(input$heatmap_x) & !is.null(input$heatmap_y) & length(input$colorpalettes_hm)){
		heatPlot(d=dat(), d.stat=aggStatsID(), d2=dat_heatmap(), x=input$heatmap_x, y=input$heatmap_y, z=input$statHeatmap, Log=input$log_hm,
			panels=facetPanelsHeatmap(), facet.by=input$facetHeatmap,
			fontsize=input$plotFontSizeHeatmap, colpal=input$colorpalettes_hm, reverse.colors=input$revHeatmapColors, aspect_1to1=input$aspect1to1, show.values=input$showHeatmapVals,
			show.overlay=input$hm_showCRU, overlay=CRU(),
			plot.title=plot_hm_title(), plot.subtitle=plot_hm_subtitle(), show.panel.text=input$hm_showPanelText, show.title=input$hm_showTitle,
			lgd.pos=input$legendPosHeatmap, units=currentUnits(), pooled.var=pooledVarHeatmap(), plot.theme.dark=input$hm_plotThemeDark, logo.mat=logo.mat, ...)
	} else NULL
}

doPlot_var <- function(...){
	if(permitPlot() & !is.null(pooled.var3()) & !is.null(input$group3)){
		if(!(input$group3!="None" & !length(input$colorpalettes_vr))){
			varPlot(d=dat(), x=input$xvar, y=aggStatsID(), y.name=input$aggStats, stat=stat(), around.mean=input$variability, d.grp=datCollapseGroups(), d.pool=datCollapsePooled(),
				grp=input$group3, n.grp=n.groups3(), ingroup.subjects=subjectChoices3(),
				panels=facet.panels3(), facet.by=input$facet3, vert.facet=input$vert.facet3,
				fontsize=input$plotFontSize3, colpal=input$colorpalettes_vr,
				boxplots=input$boxplots, pts.alpha=input$alpha3, bartype=input$bartype3, bardirection=input$bardirection3,
				show.points=input$vr_showpts, show.lines=input$vr_showlines, show.overlay=input$vr_showCRU, overlay=CRU(),
				jit=input$vr_jitterXY, plot.title=plot_var_title(), plot.subtitle=plot_var_subtitle(), show.panel.text=input$vr_showPanelText, show.title=input$vr_showTitle, lgd.pos=input$legendPos3,
				units=currentUnits(), yrange=input$yrange, clbootbar=input$clbootbar, clbootsmooth=input$clbootsmooth,
				plot.theme.dark=input$vr_plotThemeDark, logo.mat=logo.mat, ...)
		} else NULL
	} else NULL
}

doPlot_spatial <- function(...){
	if(permitPlot() & !is.null(pooledVarSpatial()) & !is.null(input$groupSpatial)){
		if(!(input$groupSpatial!="None" & !length(input$colorpalettes_sp))){
			spatialPlot(d=dat_spatial(), x=input$spatial_x, y="Val", grp=input$groupSpatial, n.grp=nGroupsSpatial(), ingroup.subjects=subjectChoicesSpatial(), plottype=input$plotTypeSpatial,
				thin.sample=as.numeric(input$thinSpatialSample), panels=facetPanelsSpatial(), facet.by=input$facetSpatial, vert.facet=input$vertFacetSpatial,
				fontsize=input$plotFontSizeSpatial, colpal=input$colorpalettes_sp,
				linePlot=input$linePlotSpatial, boxplots=input$boxplotsSpatial, pts.alpha=input$alphaSpatial, density.type=input$densityTypeSpatial, strip.direction=input$stripDirectionSpatial,
				show.points=input$sp_showpts, show.lines=input$sp_showlines, show.overlay=input$sp_showCRU, overlay=CRU_spatial(),
				jit=input$sp_jitterXY, plot.title=plot_spatial_title(), plot.subtitle=plot_spatial_subtitle(), show.panel.text=input$sp_showPanelText, show.title=input$sp_showTitle, lgd.pos=input$legendPosSpatial,
				units=currentUnits(),
				plot.theme.dark=input$sp_plotThemeDark, logo.mat=logo.mat, ...)
		} else NULL
	} else NULL
}

# Primary outputs
# Time series plot
output$PlotTS <- renderPlot({
	if(twoBtnNullOrZero_ts()) return()
	isolate({
		progress <- Progress$new(session, min=1, max=10)
		on.exit(progress$close())
		progress$set(message="Plotting, please wait", detail="Generating plot...")
		doPlot_ts(show.logo=F)
	})
}, height=function(){ if(twoBtnNullOrZero_ts()) 0 else 700 }, width=1200)

output$dlCurPlotTS <- downloadHandler(
	filename='timeseries.pdf',
	content=function(file){
		if(input$ts_plotThemeDark) bg <- "black" else bg <- "white"
		pdf(file = file, width=1.5*12, height=1.5*7, pointsize=12, onefile=FALSE, bg=bg); doPlot_ts(show.logo=T); dev.off()
	}
)

output$dlCurTableTS <- downloadHandler(
	filename=function(){ 'timeseries_data.csv' }, content=function(file){ write.csv(dat(), file) }
)

# Scatterplot
plot_scatter_ht <- function(){
	if(twoBtnNullOrZero_sc()) return(0)
	ht <- 700
	if(!is.null(facet.panels2())){
		cols <- ceiling(sqrt(facet.panels2()))
		rows <- ceiling(facet.panels2()/cols)
		ht <- ht*(rows/cols)
	}
	ht
}

output$PlotScatter <- renderPlot({
	if(twoBtnNullOrZero_sc()) return()
	isolate({
		progress <- Progress$new(session, min=1, max=10)
		on.exit(progress$close())
		progress$set(message="Plotting, please wait", detail="Generating plot...")
		doPlot_scatter(show.logo=F)
		})
}, height=plot_scatter_ht, width=700)

output$dlCurPlotScatter <- downloadHandler(
	filename='scatterplot.pdf',
	content=function(file){
		if(input$sc_plotThemeDark) bg <- "black" else bg <- "white"
		pdf(file = file, width=1.5*12, height=1.5*12, pointsize=12, onefile=FALSE, bg=bg); doPlot_scatter(show.logo=T); dev.off()
	}
)

output$dlCurTableScatter <- downloadHandler(
	filename=function(){ 'scatterplot_data.csv' }, content=function(file){ write.csv(dat2(), file) }
)

# Variability plot
output$PlotVariability <- renderPlot({
	if(twoBtnNullOrZero_vr()) return()
	isolate({
		progress <- Progress$new(session, min=1, max=10)
		on.exit(progress$close())
		progress$set(message="Plotting, please wait", detail="Generating plot...")
		doPlot_var(show.logo=F)
		})
}, height=function(){ if(twoBtnNullOrZero_vr()) 0 else 700 }, width=1200)

output$dlCurPlotVariability <- downloadHandler(
	filename='variability.pdf',
	content=function(file){
		if(input$vr_plotThemeDark) bg <- "black" else bg <- "white"
		pdf(file = file, width=1.5*12, height=1.5*7, pointsize=12, onefile=FALSE, bg=bg); doPlot_var(show.logo=T); dev.off()
	}
)

output$dlCurTableVariability <- downloadHandler(
	filename=function(){ 'variability_data.csv' }, content=function(file){ write.csv(dat(), file) }
)

# Heatmap plot
output$PlotHeatmap <- renderPlot({
	if(twoBtnNullOrZero_hm()) return()
	isolate({
		progress <- Progress$new(session, min=1, max=10)
		on.exit(progress$close())
		progress$set(message="Plotting, please wait", detail="Generating plot...")
		doPlot_heatmap(show.logo=F)
		})
}, height=function(){ if(twoBtnNullOrZero_hm()) 0 else 700 }, width=1200)

output$dlCurPlotHeatmap <- downloadHandler(
	filename='heatmap.pdf',
	content=function(file){
		if(input$hm_plotThemeDark) bg <- "black" else bg <- "white"
		pdf(file = file, width=1.5*12, height=1.5*7, pointsize=12, onefile=FALSE, bg=bg); doPlot_heatmap(show.logo=T); dev.off()
	}
)

output$dlCurTableHeatmap <- downloadHandler(
	filename=function(){ 'heatmap_data.csv' }, content=function(file){ write.csv(dat(), file) }
)

# Spatial plot
output$PlotSpatial <- renderPlot({
	if(twoBtnNullOrZero_sp()) return()
	isolate({
		progress <- Progress$new(session, min=1, max=10)
		on.exit(progress$close())
		progress$set(message="Plotting, please wait", detail="Generating plot...")
		doPlot_spatial(show.logo=F)
		})
}, height=function(){ if(twoBtnNullOrZero_sp()) 0 else 700 }, width=1200)

output$dlCurPlotSpatial <- downloadHandler(
	filename='spatial.pdf',
	content=function(file){
		if(input$sp_plotThemeDark) bg <- "black" else bg <- "white"
		pdf(file = file, width=1.5*12, height=1.5*7, pointsize=12, onefile=FALSE, bg=bg); doPlot_spatial(show.logo=T); dev.off()
	}
)

output$dlCurTableSpatial <- downloadHandler(
	filename=function(){ 'spatial_data.csv' }, content=function(file){ write.csv(dat_spatial(), file) }
)

############################## Leaflet testing
# Create the map; this is not the "real" map, but rather a proxy
# object that lets us control the leaflet map on the page.
#map <- createLeafletMap(session, 'map')

#observe({
#	if(is.null(input$map_click)) return()
#	selectedCity <<- NULL
#})

#radiusFactor <- 1000
#observe({
#	map$clearShapes()
#	cities <- topCitiesInBounds()
#	if(nrow(cities) == 0) return()

#	map$addCircle(
#		cities$Lat,
#		cities$Lon,
#		sqrt(cities$Population)*radiusFactor/max(5, input$map_zoom)^2,
#		cities$Location,
#		list(weight=1.2, fill=TRUE, color='#8B008B')
#	)
#})

#observe({
#	event <- input$map_shape_click
#	if(is.null(event)) return()
#	map$clearPopups()
    
#	isolate({
#		cities <- topCitiesInBounds()
#		city <- cities[cities$Location == event$id,]
#		selectedCity <<- city
#		content <- as.character(tagList(
#			tags$strong(city$Location),
#			tags$br(),
#			sprintf("Estimated population, %s:", 2010), #2010?
#			tags$br(),
#			prettyNum(city$Population, big.mark=',')
#		))
#		map$showPopup(event$lat, event$lng, content, event$id)
#	})
#})

#output$desc <- reactive({
#	if(is.null(input$map_bounds)) return(list())
#	list(
#		lat=mean(c(input$map_bounds$north, input$map_bounds$south)),
#		lng=mean(c(input$map_bounds$east, input$map_bounds$west)),
#		shownCities=nrow(topCitiesInBounds()),
#		totalCities=nrow(citiesInBounds())
#	)
#})

#output$citydata <- renderTable({
#	if(nrow(topCitiesInBounds()) == 0) return(NULL)
#	topCitiesInBounds()
#}, include.rownames = FALSE)
###################################################
