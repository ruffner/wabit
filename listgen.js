var exec = require('child_process').exec;
var NUM_TO_FETCH = 50; // number of birds to get at a time, API max is 100
var FETCH_TIMEOUT = 1; // in seconds
var BIRD_COUNT = 57598; // number of birds in the mccaully library, updated on first response
var START_BIRD = 0;


fetchBirdJSON(START_BIRD); // start fetching with bird 0

function fetchBirdJSON(startIndex) {
    var cmd = './get_songs.sh ' + startIndex + ' ' + NUM_TO_FETCH;
    //console.log('cmd: ', cmd);

    exec(cmd, function (error, stdout, stderr) {
            parseBirdJSON(stdout, startIndex);
        });

    setTimeout( function() {
	    if( startIndex < BIRD_COUNT-NUM_TO_FETCH )
		fetchBirdJSON(startIndex+NUM_TO_FETCH, FETCH_TIMEOUT);
	    else
		process.exit();
	}, FETCH_TIMEOUT*1000);
}

function parseBirdJSON(dat, startCount) {
    dat = dat.replace(/\n/g, " ").replace(/\r/g, " ").replace(/\t/g," ");



    var j = JSON.parse(dat);
    var i = startCount;

    BIRD_COUNT = j.results.count;

    j.results.content.forEach( function(bird) {
	    bird['commonName'] = bird['commonName'].replace('\"', '\'');
	    console.log(String(i++),',', bird['commonName'],',',bird['mediaUrl']);
	});
}
