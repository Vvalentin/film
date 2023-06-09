/* eslint-disable max-classes-per-file */
/**
 * Das Modul besteht aus der Entity-Klasse.
 * @packageDocumentation
 */

import {
    IsArray,
    IsISO8601,
    IsInt,
    IsOptional,
    IsPositive,
    Max,
    Min,
    ValidateNested,
} from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { SchauspielerDTO } from './schauspielerDTO.js';
import { TitelDTO } from './titelDTO.js';
import { Type } from 'class-transformer';

export const MAX_BEWERTUNG = 5;

/**
 * Entity-Klasse für Filme ohne TypeORM und ohne Referenzen.
 */
export class FilmDtoOhneRef {
    // https://www.oreilly.com/library/view/regular-expressions-cookbook/9781449327453/ch04s13.html
    @ApiProperty({ example: 'Steven Spielberg', type: String })
    readonly regisseur!: string;

    @IsInt()
    @Min(0)
    @Max(MAX_BEWERTUNG)
    @ApiProperty({ example: 5, type: Number })
    readonly bewertung: number | undefined;

    @IsPositive()
    @ApiProperty({ example: 1, type: Number })
    // statt number ggf. Decimal aus decimal.js analog zu BigDecimal von Java
    readonly preis!: number;

    @IsISO8601({ strict: true })
    @IsOptional()
    @ApiProperty({ example: '2021-01-31' })
    readonly erscheinungsdatum: Date | string | undefined;
}

/**
 * Entity-Klasse für Filme ohne TypeORM.
 */
export class FilmDTO extends FilmDtoOhneRef {
    @ValidateNested()
    @Type(() => TitelDTO)
    @ApiProperty({ example: 'Der Titel', type: String })
    readonly titel!: TitelDTO; //NOSONAR

    @IsOptional()
    @IsArray()
    @ValidateNested({ each: true })
    @Type(() => SchauspielerDTO)
    @ApiProperty({ example: 'Die Schauspieler', type: String })
    readonly schauspieler: SchauspielerDTO[] | undefined;

    // SchauspielerDTO
}
/* eslint-enable max-classes-per-file */
