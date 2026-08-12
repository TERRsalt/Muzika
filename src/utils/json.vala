namespace G4 {
    public void load_or_create_tags_json () {
        string file_path = Path.build_filename (Environment.get_user_config_dir (), "tags.json");
        var file = File.new_for_path (file_path);
        if (!file.query_exists ()) create_tags_json (file_path);

        GLib.List<string> other_tags = read_tags_key ("other_tags");
        other_tags.sort (strcmp);
        //TODO // Add function to sort `other_tags`

        print ("JSON file path (it doesn't need to exist): %s\n", file_path);
    }

    public void create_tags_json (string file_path) {
        string? directory = Path.get_dirname (file_path);
        if (directory != null) {
            var parent_directory = File.new_for_path ((!) directory);
            try {
                if (!parent_directory.query_exists ()) parent_directory.make_directory_with_parents ();
            }
            catch (Error error) {
                warning ("Couldn't create directory %s\n%s", (!) directory, error.message);
                return;
            }
        }
        else {
            warning ("Couldn't access the %s directory", file_path);
            return;
        }

        var builder = new Json.Builder ();
        builder.begin_object ();

        builder.set_member_name ("hour");
        builder.begin_array ();
        builder.end_array ();

        builder.set_member_name ("date");
        builder.begin_array ();
        builder.end_array ();

        builder.set_member_name ("other_tags");
        builder.begin_array ();
        builder.end_array ();

        builder.end_object ();

        var root = builder.get_root ();
        if (root == null) {
            warning ("Couldn't create node root for the JSON file");
            return;
        }

        var generator = new Json.Generator ();
        generator.pretty = true;
        generator.set_root ((!) root);

        try {
            generator.to_file (file_path);
            print ("Created the default JSON file\n");
        }
        catch (Error error) {warning ("Couldn't create the JSON file\n%s", error.message);}
    }

    public GLib.List<string> read_tags_key (string key, string json_file = "tags.json") {
        var result = new GLib.List<string> ();

        string file_path = Path.build_filename (Environment.get_user_config_dir (), json_file);
        var file = File.new_for_path (file_path);

        if (!file.query_exists ()) {
            warning ("Tags file doesn't exist: %s", file_path);
            return result;
        }

        var parser = new Json.Parser ();
        try {parser.load_from_file (file_path);}
        catch (Error error) {
            warning ("Couldn't parse the JSON file\n%s", error.message);
            return result;
        }

        var root = parser.get_root ();
        var root_object = ((!) root).get_object ();
        var array_node = ((!) root_object).get_member (key);
        var array = (!) ((!) array_node).get_array ();

        for (uint i = 0; i < array.get_length (); i++) result.append (array.get_string_element (i));
        return result;
    }
}
