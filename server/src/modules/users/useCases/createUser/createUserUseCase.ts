import { User } from "@prisma/client";
import { prisma } from "../../../../prisma/client";
import { CreateUserDTO } from "../../interface/CreateUserDTO";
import { AppError } from "../../../../errors/AppErrors";

export class CreateUserUseCase{
    async execute({name, email, senha}: CreateUserDTO): Promise<User>{

        const userExiste = await prisma.user.findUnique({
            where: { email }
        });

        if(userExiste){
            throw new AppError('Usuário já existe');
        }

        
        const user = await prisma.user.create({
            data: {
                name,
                email,
                senha
            }
        });

        
        return user;
    }
}