import { prisma } from "../../../../prisma/client";
import { CriaUserDTO } from "../../interface/CriaUserDTO";
import { AppError } from "../../../../errors/AppErrors";

export class CreateUserUseCase{
    async execute({name, email, senha}: CriaUserDTO): Promise<Object>{

        const userExiste = await prisma.user.findUnique({
            where: { email }
        });

        
        if(userExiste){
            console.log("Usuário já existe");
            throw new AppError('Usuário já existe');
        }

        const user = await prisma.user.create({
            data: {
                name,
                email,
                senha
            }
        });

        // remove a senha do retorno
        let userReturn = {
            id: user.id,
            name: user.name,
            email: user.email,
            criacao: user.criacao,
            Atualizado: user.Atualizado
        }

        console.log("Usuário criado com sucesso");
        console.log(userReturn);
        
        return userReturn;
    }
}