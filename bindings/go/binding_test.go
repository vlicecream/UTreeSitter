package tree_sitter_unreal_cpp_test

import (
	"testing"

	tree_sitter "github.com/tree-sitter/go-tree-sitter"
	tree_sitter_unreal_cpp "github.com/vlicecream/utreesitter/bindings/go"
)

func TestCanLoadGrammar(t *testing.T) {
	language := tree_sitter.NewLanguage(tree_sitter_unreal_cpp.Language())
	if language == nil {
		t.Errorf("Error loading Unreal C++ grammar")
	}
}
