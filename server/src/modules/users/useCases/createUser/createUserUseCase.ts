import { User } from "@prisma/client";
import { prisma } from "../../../../prisma/client";
import { CreateUserDTO } from "../../interface/CreateUserDTO";
import { AppError } from "../../../../errors/AppErrors";

export class CreateUserUseCase{
    async execute({name, email, senha}: CreateUserDTO): Promise<Object>{

        const userExiste = await prisma.user.findUnique({
            where: { email }
        });

        
        if(userExiste){
            console.log("Usuário já existe");
            throw new AppError('Usuário já existe');
        }

        let user = await prisma.user.create({
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