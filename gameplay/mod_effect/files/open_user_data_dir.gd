extends KURO_Effect_OpenDirectoryInShell
class_name KURO_Effect_OpenUserDataDirectoryInShell

func apply_string():
	return OS.get_user_data_dir().path_join(path)
