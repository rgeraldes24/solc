/*
	This file is part of hyperion.
	hyperion is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
	hyperion is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	You should have received a copy of the GNU General Public License
	along with hyperion.  If not, see <http://www.gnu.org/licenses/>.
*/

#pragma once

#include <libhyputil/AnsiColorized.h>
#include <libhyputil/Assertions.h>
#include <libhyputil/CommonData.h>
#include <libhyputil/Exceptions.h>

#include <boost/preprocessor/cat.hpp>
#include <boost/preprocessor/facilities/empty.hpp>
#include <boost/preprocessor/facilities/overload.hpp>

namespace hyperion::frontend::test
{

struct InternalHyptestError: virtual util::Exception {};

#if !BOOST_PP_VARIADICS_MSVC
#define hyptestAssert(...) BOOST_PP_OVERLOAD(hyptestAssert_,__VA_ARGS__)(__VA_ARGS__)
#else
#define hyptestAssert(...) BOOST_PP_CAT(BOOST_PP_OVERLOAD(hyptestAssert_,__VA_ARGS__)(__VA_ARGS__),BOOST_PP_EMPTY())
#endif

#define hyptestAssert_1(CONDITION) \
	hyptestAssert_2((CONDITION), "")

#define hyptestAssert_2(CONDITION, DESCRIPTION) \
	assertThrowWithDefaultDescription( \
		(CONDITION), \
		::hyperion::frontend::test::InternalHyptestError, \
		(DESCRIPTION), \
		"Hyptest assertion failed" \
	)

class TestParserError: virtual public util::Exception
{
public:
	explicit TestParserError(std::string const& _description)
	{
		*this << util::errinfo_comment(_description);
	}
};

/**
 * Representation of a notice, warning or error that can occur while
 * formatting and therefore updating an interactive function call test.
 */
struct FormatError
{
	enum Type
	{
		Notice,
		Warning,
		Error
	};

	explicit FormatError(Type _type, std::string _message):
		type(_type),
		message(std::move(_message))
	{}

	Type type;
	std::string message;
};
using FormatErrors = std::vector<FormatError>;

/**
 * Utility class that collects notices, warnings and errors and is able
 * to format them for ANSI colorized output during the interactive update
 * process in ihyptest.
 * Its purpose is to help users of ihyptest to automatically
 * update test files and always keep track of what is happening.
 */
class ErrorReporter
{
public:
	explicit ErrorReporter() {}

	/// Adds a new FormatError of type Notice with the given message.
	void notice(std::string _notice)
	{
		m_errors.push_back(FormatError{FormatError::Notice, std::move(_notice)});
	}

	/// Adds a new FormatError of type Warning with the given message.
	void warning(std::string _warning)
	{
		m_errors.push_back(FormatError{FormatError::Warning, std::move(_warning)});
	}

	/// Adds a new FormatError of type Error with the given message.
	void error(std::string _error)
	{
		m_errors.push_back(FormatError{FormatError::Error, std::move(_error)});
	}

	/// Prints all errors depending on their type using ANSI colorized output.
	/// It will be used to print notices, warnings and errors during the
	/// interactive update process.
	std::string format(std::string const& _linePrefix, bool _formatted)
	{
		std::stringstream os;
		for (auto const& error: m_errors)
		{
			switch (error.type)
			{
			case FormatError::Notice:

				break;
			case FormatError::Warning:
				util::AnsiColorized(
					os,
					_formatted,
					{util::formatting::YELLOW}
				) << _linePrefix << "Warning: " << error.message << std::endl;
				break;
			case FormatError::Error:
				util::AnsiColorized(
					os,
					_formatted,
					{util::formatting::RED}
				) << _linePrefix << "Error: " << error.message << std::endl;
				break;
			}
		}
		return os.str();
	}

private:
	FormatErrors m_errors;
};

}
