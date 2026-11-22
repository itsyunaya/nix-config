#include <curl/curl.h>
#include <curl/easy.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>

#define PROJECT_NAME "lc"
#define PROJECT_VERSION "1.0"
#define USER_AGENT PROJECT_NAME "/" PROJECT_VERSION "\n"

#define LICENSE_FILENAME "LICENSE"

#define EUPL_URL                                                               \
	"https://interoperable-europe.ec.europa.eu/sites/default/files/"           \
	"custom-page/attachment/2020-03/EUPL-1.2%20EN.txt"
#define GPL_URL "https://www.gnu.org/licenses/gpl-3.0.txt"
#define AGPL_URL "https://www.gnu.org/licenses/agpl-3.0.txt"

// returns 0 if the checked file is not present
// in the current dir, which is all we care about
int check_license_already_exist() {
	struct stat s = {0};
	return stat(LICENSE_FILENAME, &s);
}

int main(int argc, char **argv) {
	if (argc != 2) {
		fprintf(stderr, "Usage: %s <eupl|gpl|agpl>\n", argv[0]);
		return EXIT_FAILURE;
	}

	if (check_license_already_exist() == 0) {
		fprintf(stderr,
				"Error: License file already exists in directory, exiting.\n");
		return EXIT_FAILURE;
	}

	const char *license_url;

	if (strcmp(argv[1], "eupl") == 0) {
		license_url = EUPL_URL;
	} else if (strcmp(argv[1], "gpl") == 0) {
		license_url = GPL_URL;
	} else if (strcmp(argv[1], "agpl") == 0) {
		license_url = AGPL_URL;
	} else {
		fprintf(stderr, "Error: unrecognized license entered\n");
		return EXIT_FAILURE;
	}

	CURL *curl;
	CURLcode result = curl_global_init(CURL_GLOBAL_ALL);
	if (result != CURLE_OK) {
		fprintf(stderr, "Error: curl global initialisation failed.\n");
		return result;
	}

	curl = curl_easy_init();
	if (curl) {
		FILE *output = fopen(LICENSE_FILENAME, "w");

		curl_easy_setopt(curl, CURLOPT_WRITEDATA, output);
		curl_easy_setopt(curl, CURLOPT_URL, license_url);
		curl_easy_setopt(curl, CURLOPT_USERAGENT, USER_AGENT);
		curl_easy_setopt(curl, CURLOPT_CA_CACHE_TIMEOUT, 604800L);
		curl_easy_setopt(curl, CURLOPT_TIMEOUT, 5L);

		result = curl_easy_perform(curl);
		if (result != CURLE_OK)
			fprintf(stderr, "Web request error: %s\n",
					curl_easy_strerror(result));

		curl_easy_cleanup(curl);
		fclose(output);
	} else
		fprintf(stderr, "Error: curl initialisation failed.\n");

	curl_global_cleanup();

	return result;
}
