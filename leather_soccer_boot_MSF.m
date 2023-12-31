% Clearing workspace and command window
clear all;
clc;

% Setting up global variables
global global_info;
global_info.STOP_AT = 80; % Setting the simulation stop time to 100

% Quality levels categorized as 'AQuality' and 'BQuality'
global_info.Quality = {'AQuality','BQuality'};

% Initializing the Petri net with a specific structure defined externally
pns = pnstruct('leather_soccer_boot_pdf');

% Setting the initial condition for the simulation
dynamic.m0 = {'pManufacturingStage',20};

% Specifying transition firing times

    % Specifying transition firing times
dynamic.ft = {
    'tMoveMaterialToCuttingStage', 1,...
    'tMaterialCutting', 4,...
    'tSeaming', 2,...
    'tSoleAttachment', 5,...
    'tEyeletFixing', 5,...
    'tLaceInsertion', 3,... 
    'tDesignImprinting',4 ,...
    'tSizeNumbering', 3,...
    'tSortingMatching', 3,... 
    'tQualityVerification', 5,...
    'tDisposePoorQuality', 1,...
    'tTransferConfirmedQuality', 2,...
    'tCleaning', 3,...
    'tPackagingStage', 3
};


% Defining fixed costs for transitions
dynamic.fc_fixed = {
    'tMoveMaterialToCuttingStage', 5000,...
    'tMaterialCutting',10000,...
    'tSeaming',15000,...
    'tSoleAttachment',12000,...
    'tEyeletFixing',8000,...
    'tLaceInsertion',6000,...
    'tDesignImprinting',7000,...
    'tSortingMatching',13000,...
    'tSizeNumbering',5000,...
    'tQualityVerification',10000,...
    'tDisposePoorQuality', 2000,...
     'tTransferConfirmedQuality', 1500,...
    'tCleaning',4000,...
    'tPackagingStage',9000,...
};

% Defining variable costs based on transition firings
dynamic.fc_variable = {
    'tMoveMaterialToCuttingStage', 1000,...
    'tMaterialCutting',2000,...
    'tSeaming',3000,...
    'tSoleAttachment',1200,...
    'tEyeletFixing',1500,...
    'tLaceInsertion',1200,...
    'tDesignImprinting',1800,...
    'tSortingMatching',2700,...
    'tSizeNumbering',1000,...
    'tQualityVerification',2500,...
    'tDisposePoorQuality', 500,...
     'tTransferConfirmedQuality', 400,...
    'tCleaning',800,...
    'tPackagingStage',2200,...
};

% Defining resources availability and working hours
dynamic.re = {
    'tMoveMaterialToCuttingStage', 4,8,...
    'rMaterialCutting',10,8,...
    'rSeaming',30,8,...
    'rSoleAttachment',5,8,...
    'rEyeletFixing',4,8,...
    'rLaceInsertion',25,8,...
    'rDesignImprinting',8,8,...
    'rSizeNumbering',15,8,...
    'rSortingMatching',12,8,...
    'rQualityVerification',8,8,...
    'tDisposePoorQuality', 5,8,...
     'tTransferConfirmedQuality', 4,8,...
    'rCleaning',15,8,...
    'rPackagingStage',60,8
};

% Initializing dynamics for the Petri net simulation
pni = initialdynamics(pns, dynamic);

% Running the Petri net simulation
sim = gpensim(pni);

% Visualizing the simulation results through various plots
plotp(sim, {
    'pManufacturingStage',...
    'pMaterialCutting',...
    'pSeaming',...
    'pSoleAttachment',...
    'pEyeletFixing',...
    'pLaceInsertion',...
    'pDesignImprinting',...
    'pSizeNumbering',...
    'pSortingMatching',... 
    'pQualityVerification',...
    'pQualityConfirmed',...
    'pDisposePoorQuality',...
    'pCleaning',...
    'pPackagingStage',...
    'pReadyForShipment',...
});

% Displaying additional analysis and results from the simulation
plotGC(sim);
prnss(sim);
prnfinalcolors(sim,{'pReadyForShipment'});
prnschedule(sim);
cotree(pni,1,1);
