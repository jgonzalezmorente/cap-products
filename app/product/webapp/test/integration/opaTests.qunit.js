sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'logaligroup/product/test/integration/FirstJourney',
		'logaligroup/product/test/integration/pages/ProductsList',
		'logaligroup/product/test/integration/pages/ProductsObjectPage',
		'logaligroup/product/test/integration/pages/ReviewObjectPage'
    ],
    function(JourneyRunner, opaJourney, ProductsList, ProductsObjectPage, ReviewObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('logaligroup/product') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheProductsList: ProductsList,
					onTheProductsObjectPage: ProductsObjectPage,
					onTheReviewObjectPage: ReviewObjectPage
                }
            },
            opaJourney.run
        );
    }
);