#include <cassert>
#include <iostream>
#include <memory>
#include <string>
#include <vector>

template <typename T>
class matrix_t {
	size_t n = 0, m = 0;
	std::unique_ptr<T[]> mem;

public:
	matrix_t() = default;
	matrix_t(size_t n, size_t m, const T& v)
		: n(n)
		, m(m)
		, mem(std::make_unique<T[]>(n * m))
	{
		std::fill_n(mem.get(), n * m, v);
	}
	T* operator[](size_t i)
	{
		return &mem[i * m];
	}
	const T* operator[](size_t i) const
	{
		return &mem[i * m];
	}
	size_t rows() const { return n; }
	size_t cols() const { return m; }
};

matrix_t<size_t> lce(const std::string& S)
{
	const auto n = S.size();
	matrix_t<size_t> dp(n + 1, n + 1, 0); // +1 so we don't have to handle the base case

	std::vector<std::vector<size_t>> adj(n);
	{ // compute adj
		size_t after_close; // points to char immediately following ')'
		std::vector<size_t> vars;
		for (size_t i = n; i-- > 0;) {
			if (S[i] == '(') {
				vars.emplace_back(i + 1);
				adj[i] = std::move(vars);
				vars.clear();
			} else if (S[i] == '|') {
				vars.emplace_back(i + 1);
				adj[i].emplace_back(after_close);
			} else if (S[i] == ')') {
				after_close = i + 1;
				adj[i].emplace_back(after_close);
			} else { // normal character
				adj[i].emplace_back(i);
			}
		}
	}

	const auto is_syntax = [](char c) {
		return c == '(' or c == '|' or c == ')';
	};

	for (size_t i = n; i-- > 0;) {
		for (size_t j = n; j-- > 0;) {
			if (not is_syntax(S[i]) and not is_syntax(S[j])) {
				dp[i][j] = S[i] == S[j] ? 1 + dp[i + 1][j + 1] : 0;
				continue;
			}
			for (auto ii : adj[i])
				for (auto jj : adj[j]) {
					assert((ii > i and jj >= j) or (ii >= i and jj > j));
					dp[i][j] = std::max(dp[i][j], dp[ii][jj]);
				}
		}
	}
	return dp;
}

int main()
{
	std::string S;
	std::cin >> S;

	auto t = lce(S);

	// print matrix
	std::cout << ' ';
	for (char c : S)
		std::cout << ' ' << c;
	std::cout << '\n';
	for (size_t i = 0; i < t.rows(); i++) {
		std::cout << (i < S.size() ? S[i] : ' ');
		for (size_t j = 0; j < t.cols(); j++)
			std::cout << ' ' << t[i][j];
		std::cout << '\n';
	}
}
