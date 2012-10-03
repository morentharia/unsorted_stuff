#include <string>
#include <memory>
#include <stdexcept>
#include <iostream>
#include <boost/shared_ptr.hpp>
// #include <boost/noncopyable.hpp>

class CodeGenerator
{
public:
    virtual std::string code() = 0;
    virtual std::string thing() = 0;
    virtual ~CodeGenerator() { };
};

class JavaCodeGenerator : public CodeGenerator
{
public:
    std::string code() { return std::string("Java Code") + thing();}
    std::string thing() { return std::string("Java thing"); }
};

class CppCodeGenerator : public CodeGenerator
{
public:
    std::string code() { return std::string("Cpp Code") + thing() + thing(); }
    std::string thing() { return std::string("Cpp thing"); }
};

class PhpCodeGenerator : public CodeGenerator
{
public:
    std::string code() { return std::string("Php Code") + thing() + thing() + thing(); }
    std::string thing() { return std::string("Php thing"); }
};


typedef boost::shared_ptr<CodeGenerator> CodeGeneratorPtr;

class CodeGenratorFactory
{
public:
    enum Lang {JAVA, C_PLUS_PLUS, PHP};
 
    static CodeGeneratorPtr create(Lang lang) 
    {
        switch (lang) 
        {
            case JAVA:
                return CodeGeneratorPtr(new JavaCodeGenerator());
            case C_PLUS_PLUS:
                return CodeGeneratorPtr(new CppCodeGenerator());
            // case PHP:
            //     return CodeGeneratorPtr(new PhpCodeGenerator());
            default:
                throw std::logic_error("Bad language");
        }
    }
};

int
main() 
{
    try 
    {
        CodeGeneratorPtr cg = CodeGenratorFactory::create(CodeGenratorFactory::C_PLUS_PLUS);
        std::cout << cg->code() << std::endl;

        CodeGeneratorPtr ec = CodeGenratorFactory::create(CodeGenratorFactory::PHP);
        std::cout << ec->code() << std::endl;
    } 
    catch (const std::logic_error &e) 
    {
        std::cout << "ERROR: " << e.what() << std::endl;
    }

    return 0;
}
